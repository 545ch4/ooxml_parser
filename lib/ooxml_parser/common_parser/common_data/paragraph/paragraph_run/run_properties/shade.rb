# frozen_string_literal: true

module OoxmlParser
  # Class for parsing `w:shd` object
  class Shade < OOXMLDocumentObject
    # @return [Symbol] value of shade
    attr_accessor :value
    # @return [Symbol] color of shade
    attr_accessor :color
    # @return [Color] fill of shade
    attr_accessor :fill

    def initialize(value: nil,
                   color: nil,
                   fill: nil,
                   parent: nil)
      @value = value
      @color = color
      @fill = fill
      super(parent: parent)
    end

    # @return [String] text representation
    def to_s
      "Value: `#{value}`, "\
        "Color: `#{color}`, "\
        "Fill: `#{fill}`"
    end

    # Parse Shade
    # @param [Nokogiri::XML:Node] node with Shade
    # @return [Shade] result of parsing
    def parse(node)
      node.attributes.each do |key, value|
        case key
        when 'val'
          @value = value.value.to_sym
        when 'color'
          @color = value.value.to_sym
        when 'fill'
          @fill = Color.new(parent: self).parse_hex_string(value.value.to_s)
        end
      end
      self
    end

    # Helper method to get background color
    # @return [OoxmlParser::Color]
    def to_background_color
      return nil unless fill

      background_color = fill
      background_color.set_style(value) if value
      background_color
    end

    extend Gem::Deprecate
    deprecate :to_background_color, 'use shade direct methods', 2077, 1
  end
end
