CarrierWave::Backgrounder.configure do |c|
  # c.backend :delayed_job, queue: :reportable_xls_cw
  # c.backend :resque, queue: :reportable_xls_cw
  # c.backend :sidekiq, queue: :reportable_xls_cw
  # c.backend :girl_friday, queue: :reportable_xls_cw
  # c.backend :sucker_punch, queue: :reportable_xls_cw
  # c.backend :qu, queue: :reportable_xls_cw
  # c.backend :qc
end
