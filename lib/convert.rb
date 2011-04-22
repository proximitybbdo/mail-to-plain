#!/usr/bin/env ruby

require 'rubygems'
require 'hpricot_scrub'

def convert_to_plain_from_url(url)
  html = open(url).read

  convert_to_plain html
end

def convert_to_plain(html)
  html = html.gsub(/(<br\s*\/?>\s*)+/, "~br~")

  # Hpricot Sub
  doc = Hpricot(html)

  config = {
    :elem_rules => {
      'a' => {
        'href'  =>  true
      },
      'style' => false 
    },
    :default_elem_rule => :strip,
    :default_comment_rule => false,
    :default_attribute_rule => false
  }

  text_scrub = doc.scrub(config)
  text = text_scrub.to_s

  # custom
  text = text.gsub(/&nbsp;/, '')
  text = text.gsub(/\t/, '')
  text = text.gsub(/^\s+/, '') # starting whitespace
  text = text.gsub(/\s+$/, $/) # trailing whitespace
  text = text.gsub(/^<!DOCTYPE .*$/, '')
  text = text.gsub(/~br~/, "\n")

  # links
  text.gsub!(/<a\s+[^>]*href="(.*?)\"[^>]*>(.*?)<\/a>/i, '\\2 (\\1)')

  File.open('tmp/result.txt', 'w') do |f|  
    f.puts text
  end

  text
end
