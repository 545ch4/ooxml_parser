require 'spec_helper'

describe 'My behaviour' do
  it 'table_boders_inside_color' do
    docx = OoxmlParser::DocxParser.parse_docx('spec/document/elements/table/properties/borders/table_boders_inside_color.docx')
    expect(docx.elements[1].table_properties.table_borders.inside_vertical.color).to eq(OoxmlParser::Color.new(255, 0, 0))
    expect(docx.elements[1].table_properties.table_borders.inside_horizontal.color).to eq(OoxmlParser::Color.new(255, 0, 0))
  end
end
