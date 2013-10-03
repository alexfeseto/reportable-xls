require 'rjb'

module SpreadsheetProcessor

  def ClassMethods
    def process_spreadsheet
      process :analyze_spreadsheet
    end
  end
  
  def analyze_spreadsheet
    system = Rjb::import('java.lang.System')
    rjb_excel_xml_builder = Rjb::import('com.reportable.util.ExcelXmlBuilder')
    system.setProperty("java.awt.headless", "true")
    excel_xml_builder = rjb_excel_xml_builder.new()
    Rjb::import('com.reportable.util.ExcelXmlBuilder')
    # Rails.logger.info "***** processing ***** #{self.model} >>>"
    xml_content = excel_xml_builder.generateXml(self.current_path)
    # Rails.logger.info "xml_content = #{xml_content}"
    if xml_content == 'Error'
      return false
    else
      self.model.update_attributes(:xml_content => xml_content)
    end
    # Rails.logger.info self.model.xml_content
  end
end