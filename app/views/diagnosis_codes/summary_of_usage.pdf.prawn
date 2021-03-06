prawn_document(:page_layout => :landscape) do |pdf|

  pdf.y = pdf.bounds.top - 0.5 * 37

  # Head
  pdf.text_box("Diagnosis Codes - Summary of usage", size: 20, style: :bold, at: [0, pdf.y])
  pdf.text_box(Date.today.strftime('%d/%m/%Y'), size: 16, at: [pdf.bounds.right - (2.8*37), pdf.y], style: :bold)

  pdf.y -= 2 * 37

  # Headers
  pdf.text_box("Code", at: [0, pdf.y], style: :bold)
  pdf.text_box("Description", at: [3*37, pdf.y], style: :bold)
  pdf.text_box("Record #/%", at: [14*37, pdf.y], style: :bold)

  pdf.y -= (0.5 * 37)

  pdf.text_box("Name", at: [4*37, pdf.y], size: 7)
  pdf.text_box("Account", at: [8*37, pdf.y], size: 7)
  pdf.text_box("CaseDescription", at: [12*37, pdf.y], size: 7)

  @data.each do |data|
    diagnosis_code = data[:diagnosis_code]

    if pdf.y <= 1*37
      pdf.start_new_page
    end

    pdf.y -= 1.cm
    
    pdf.text_box(diagnosis_code.code, size: 9, style: :bold, at: [0, pdf.y])
    pdf.text_box(diagnosis_code.description, size: 9, at: [3*37, pdf.y])
    pdf.text_box("#{data[:count_things]} / #{data[:percents]} %", size: 9, at: [14*37, pdf.y])
      
    data[:patient_things].each do |patient_thing|
      if pdf.y <= 1*37
        pdf.start_new_page
      end
      
      pdf.y -= (1*37)
      
      pdf.text_box(patient_thing.patient.title, size: 7, at: [3*37, pdf.y])
      pdf.text_box(patient_thing.patient.account_code.present? ? patient_thing.patient.account_code : '', size: 7, at: [8*37, pdf.y])
      pdf.text_box(patient_thing.description, size: 7, at: [12*37, pdf.y])
    end
  end

  pdf.y -= 1*37
  pdf.text_box("Total Records #{@total_things} / 100.00%", at: [12*37, pdf.y], size: 8, style: :bold)

end