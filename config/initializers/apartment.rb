Apartment.configure do |config|
  #these models will always be searched in the public schema
  config.excluded_models = %w(Tenant)
  #tell apartment where the list of schemas can be found
  config.tenant_names = lambda { Tenant.pluck(:db_name) }
end

