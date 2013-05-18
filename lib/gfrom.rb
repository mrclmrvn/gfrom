require "curb"
require "nokogiri"
require "json"
require 'digest/sha1'
require "tmpdir"

class Gfrom

  attr_accessor :form, :fields

  MATCHERS = '//input[@type="text"] | //input[@type="hidden"] | //textarea | //form'

  def initialize(url, reset = false)
    @form = Hash.new
    @fields = []

    cache = "#{Dir.tmpdir}/#{Digest::SHA1.hexdigest(url)}"
    File.delete cache if reset

    unless File.exists?(cache)
      req = Curl.get(url)
      File.open(cache, "w") do |f|
        f.write req.body_str
      end
    end

    keys = []

    doc = Nokogiri::XML(File.open(cache))
    doc.search(MATCHERS).each do |node|
      case node.name
      when "form"
        @form[:action] = node.attributes["action"].value unless @form.has_key?(:action)
      else
        n = hash_it(node)
        @fields << n
        keys << n[:name]
      end
    end
    @form[:keys] = keys.uniq

  end

  def submit(params)
    response = Curl.post(@form[:action], params)
    doc = Nokogiri::XML.parse(response.body_str)
    errorheader = doc.search('//div[@class="errorheader"]')
    success = errorheader.empty?
    out = { :success => success, :message => doc.search('//title').first.text.strip }
    unless success
      out[:message] = errorheader.children.first.text.strip
    end
    out
  end

  private

  def hash_it(node)
    object = Hash.new
    object[:element] = node.name
    node.attributes.each do |k,v|
      object[k.to_sym] = v.value
      if k == "id"
        label = node.search("//label[@for=\"#{v.value}\"]").first
        object[:label] = label.children.first.text.strip if label
        object[:required] = true unless label.search("//label[@for=\"#{v.value}\"]/span[contains(@class, \"required\")]").empty?
      end
    end
    object
  end

end