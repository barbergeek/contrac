Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.logger = Rails.logger
Delayed::Worker.backend = :active_record
