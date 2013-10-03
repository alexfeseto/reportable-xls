require 'rjb'

module SpreadsheetProcessor

  def ClassMethods
    def process_spreadsheet
      process :analyze_spreadsheet
    end
  end
  
  def analyze_spreadsheet
    begin
      system = Rjb::import('java.lang.System')
      rjb_excel_xml_builder = Rjb::import('com.reportable.util.ExcelXmlBuilder')
      system.setProperty("java.awt.headless", "true")
      excel_xml_builder = rjb_excel_xml_builder.new()
      Rjb::import('com.reportable.util.ExcelXmlBuilder')
      # Rails.logger.info "***** processing ***** #{self.model} >>>"
      xml_content = excel_xml_builder.generateXml(self.current_path)
      if xml_content == 'ERROR'
        Rails.logger.info "xml_content = #{xml_content}"
        self.model.errors.add(:base, "Processing the document failed")
        return false
      else
        self.model.update_attributes(:xml_content => xml_content)
      end
    rescue exception
      Rails.logger.error exception
      self.model.errors.add(:base, "Processing the document failed")
      return false
    end
  end
end