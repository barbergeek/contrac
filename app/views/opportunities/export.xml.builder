xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.Workbook({
  'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet", 
  'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
  'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",    
  'xmlns:html' => "http://www.w3.org/TR/REC-html40",
  'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet" 
  }) do

  xml.Styles do
   xml.Style 'ss:ID' => 'Default', 'ss:Name' => 'Normal' do
     xml.Alignment 'ss:Vertical' => 'Bottom'
     xml.Borders
     xml.Font 'ss:FontName' => 'Verdana'
     xml.Interior
     xml.NumberFormat
     xml.Protection
   end
   xml.Style 'ss:ID' => 's22' do
     xml.NumberFormat 'ss:Format' => 'General Date'
   end
  end
 
  xml.Worksheet 'ss:Name' => 'Blahblah' do
    xml.Table do
      
      # Header
      xml.Row do
        for column in Opportunity.content_columns do
          xml.Cell do
            xml.Data column.human_name, 'ss:Type' => 'String'
          end
        end
      end
      
      # Rows
      for record in @records
        xml.Row do
          for column in Opportunity.content_columns do
            xml.Cell do
              xml.Data record.send(column.name), 'ss:Type' => 'String'
            end
          end
        end
      end
      
    end
  end
  
end