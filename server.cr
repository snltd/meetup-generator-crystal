require "kemal"
require "pathname"
require "yaml"
require "kilt/slang"

class Meetup
  property :words, :things, :talk, :talker, :refreshment

  def initialize
    @words = [] of String
    @words = `/bin/grep "^[a-z]*$" #{find_dict}`.split("\n")
    @things = {} of String => Array(String)
    @things = load_things
  end

  def load_things
    ret = {} of String => Array(String)

    c = YAML.parse(File.open("./all_the_things.yaml"))

    c.each do |k, v|
      ret[k.to_s] = v.map { |e| e.to_s }
    end

    ret
  end

  def find_dict
    %w(dict lib/dict).each do |d|
      dict = Pathname.new("/usr/share") + d + "words"
      puts "dict is #{dict}"
      return dict if dict.exists?
    end
    abort("Cannot find dictionary file.")
  end

  def talk
    t = things["template"].sample.to_s

    matches = t.scan(/%\w+%/)

    matches.each do |m|
      next if m[0].empty?
      t = t.sub(m[0], things[m[0][1..-2]].sample)
    end

    matches = t.scan(/RAND\d+/)

    matches.each do |m|
      t = t.sub(m[0], rand(2..(m[0].sub(/RAND/, "").to_i)).to_s)
    end
    t
  end

  def talks(count = 5)
    ret = [] of String
    until ret.size == count
      t = talk
      ret.<< t unless ret.includes?(t)
    end
    ret
  end

  def talker
    { "talker" => [things["first_name"].sample,
                   things["last_name"].sample].join(" "),
    "role" => [things["job_role"].sample, things["job_title"].sample].join(" "),
      "company" => words.sample.sub(/([^aeiou])er$/, "\\1r") + ".io" }
  end

  def refreshment
    [things["food_style"].sample, things["food"].sample].join(" ")
  end
end

m = Meetup.new

puts m.refreshment
puts m.talk

get "/api/talk" do
  { "talk" => m.talk }.merge(m.talker).to_json
end

get "/api/*" do
  [404, "not found"]
end

get "/" do
  talks = m.talks
  jobs = [] of String

  5.times do
    t = m.talker
    puts t
    jobs.<< [t["talker"], "//", t["role"], "@",
    t["company"]].join(" ")
  end

  food = m.refreshment
  render "/home/rob/work/crystal/meetup_generator/views/default.slang"
end

Kemal.run
