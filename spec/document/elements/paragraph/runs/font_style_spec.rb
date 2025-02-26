# frozen_string_literal: true

require 'spec_helper'

describe OoxmlParser::FontStyle do
  it 'OoxmlParser::FontStyle#to_s' do
    expect(described_class.new.to_s).to eq('Bold: false, Italic: false, Underlined: none, Strike: none')
  end

  it 'paragraph_style_second_paragraph' do
    docx = OoxmlParser::DocxParser.parse_docx('spec/document/elements/paragraph/runs/font_style/paragraph_style_second_paragraph.docx')
    expect(docx.element_by_description[1].character_style_array[0].font_style.italic).to eq(false)
  end

  it 'font_style_copied_paragraph' do
    docx = OoxmlParser::DocxParser.parse_docx('spec/document/elements/paragraph/runs/font_style/font_style_copied_paragraph.docx')
    expect(docx.elements[0].nonempty_runs.first.font_style).to eq(described_class.new(true, true, nil, :none))
  end

  it 'dropcap_font_style_strike_off' do
    docx = OoxmlParser::DocxParser.parse_docx('spec/document/elements/paragraph/runs/font_style/dropcap_font_style_strike_off.docx')
    expect(docx.element_by_description[0].character_style_array[0].font_style).to eq(described_class.new(false, false))
  end

  it 'dropcap_front_style_strike_on' do
    docx = OoxmlParser::DocxParser.parse_docx('spec/document/elements/paragraph/runs/font_style/dropcap_front_style_strike_on.docx')
    expect(docx.element_by_description[0].character_style_array[0].font_style).to eq(described_class.new(false, false, nil, :single))
  end

  it 'double_strikethrought' do
    docx = OoxmlParser::DocxParser.parse_docx('spec/document/elements/paragraph/runs/font_style/double_strikethrought.docx')
    expect(docx.elements.first.character_style_array.first.font_style.strike).to eq(:double)
  end

  it 'run_style_from_default' do
    docx = OoxmlParser::DocxParser.parse_docx('spec/document/elements/paragraph/runs/font_style/run_style_from_default.docx')
    expect(docx.elements.first.character_style_array[1].font).to eq('Comic Sans MS')
  end
end
