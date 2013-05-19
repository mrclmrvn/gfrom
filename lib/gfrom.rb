require "curb"
require "nokogiri"
require "json"
require "addressable/uri"
require "digest/sha1"
require "tmpdir"

class Gfrom

  attr_accessor :fields, :form

  MATCHERS = '//input[@type="text"] | //input[@type="radio"] | //input[@type="checkbox"] | //input[@type="hidden"] | //textarea | //form'

  def initialize(url, regenerate_cache = false, lang = 'en')
    @form = Hash.new
    @fields = []

    url = Gfrom::locale_url(url, lang)

    @cache = "#{Dir.tmpdir}/#{Digest::SHA1.hexdigest(url)}"
    if File.exists?(@cache) and regenerate_cache
      File.delete @cache
    end

    unless File.exists?(@cache)
      req = Curl.get(url)
      File.open(@cache, "w") do |f|
        f.write req.body_str
      end
    end

    keys = []

    doc = Nokogiri::XML(File.open(@cache))
    doc.search(MATCHERS).each do |node|
      case node.name
      when "form"
        @form[:action] = node.attributes["action"].value unless @form.has_key?(:action)
        @form[:title] = doc.search('//title').first.text.strip unless @form.has_key?(:title)
      else
        n = hash_it(node)
        @fields << n
        keys << n[:name]
      end
    end
    @form[:keys] = keys

  end

  def self.locale_url(url, lang = 'en')
    uri = Addressable::URI.parse(url)
    if uri.to_hash.select{|k,v| [:scheme, :host].include? k }.values.any?{|v| v.nil? || v.length == 0}
      raise "Invalid URI"
    end
    uri.query_values ||= Hash.new
    uri.query_values = uri.query_values.merge({"hl" => lang})
    uri.to_s
  end

  def submit(params)
    response = Curl.post(@form[:action], params)
    doc = Nokogiri::XML.parse(response.body_str)
    errorheader = doc.search('//div[@class="errorheader"]')
    success = errorheader.empty?
    out = { :success => success }
    if success
      out[:message] = doc.search('//div[@class="ss-custom-resp"]').first.text.strip rescue doc.search('//title').first.text.strip
    else
      out[:message] = errorheader.children.first.text.strip
    end
    out
  end

  private

  def hash_it(node)
    group = ["checkbox", "radio"]
    object = Hash.new
    object[:element] = node.name
    node.attributes.each do |k,v|
      object[k.to_sym] = v.value
      if k == "id"
        label = node.search("//label[@for=\"#{v.value}\"]").first
        if label
          object[:label] = label.children.first.text.strip
          object[:required] = true unless label.search("//label[@for=\"#{v.value}\"]/span[contains(@class, \"required\")]").empty?
        end
      end
      if object[:label].nil? and group.include?(object[:type])
        object[:label] = node.attributes["value"].value
      end
    end
    # override when element has all the attributes
    if (object[:type] == "checkbox" and node.search("//input[@name=\"#{object[:name]}\"]").length > 1)
      # checkbox needs name to be array'ed
      object[:name] = "#{object[:name]}[]"
    end

    object
  end

end