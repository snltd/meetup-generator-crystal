doctype html
html
  head
    title #Devops Meetup
    meta charset="utf-8"
    link href="http://fonts.googleapis.com/css?family=Roboto+Slab:300,700" rel="stylesheet"
    link href="http://allfont.net/css/?fonts=zx-spectrum" rel="stylesheet" type="text/css"
    link href="/css/main.css" rel="stylesheet"

  body
    #container
      h1 #DevOps Meetup // Shoreditch, probably // #{(Time.now + 1.days).to_s("%d/%m/%Y")}


      ul
        li 18:00 // Introduction

        li
          ' 18:10 // Lightning talk //
          span.ttitle=talks.pop
          .tperson=jobs.pop

        li
          ' 18:20 //
          span.ttitle=talks.pop
          .tperson=jobs.pop

        li 18:50 // break
        .tperson=food

        li
          ' 19:20 //
          span.ttitle=talks.pop
          .tperson=jobs.pop

        li
          ' 19:40 // Ignite //
          span.ttitle=talks.pop
          .tperson=jobs.pop

        li
          ' 20:00 //
          span.ttitle=talks.pop
          .tperson=jobs.pop

        li
          ' 20:30 // Close
          .tperson Everyone is hiring, but no one's paying

      #footer
        a href="https://github.com/snltd/meetup-generator" The code.
