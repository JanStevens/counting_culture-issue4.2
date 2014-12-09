# Helpers to setup test tenant before specs are run.
#
module TestTenantSetupHelpers
  def ensure_default_tenant
    Tenant.where(db_name: TENANT_DBNAME).first_or_initialize({ name: 'RSpec Tenant',
                                                             }) do |new_tenant|
      new_tenant.save!
    end
    ensure_schema_exists(TENANT_DBNAME)
  end

  def ensure_schema_exists(name = TENANT_DBNAME)
    unless schema_exists?(name)
      Apartment::Tenant.create(name)
    end
  end

  def ensure_schema_dropped(name = TENANT_DBNAME)
    if schema_exists?(name)
      Apartment::Tenant.drop(name)
    end
  end

  def schema_exists?(name)
    Apartment.connection.schema_exists?(name)
  end
end

# -----------------------------------------------------------------------------
# DatabaseCleaner setup
# -----------------------------------------------------------------------------
RSpec.configure do |config|
  include TestTenantSetupHelpers

  config.before(:suite) do
    # Start from a clean slate
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction

    ensure_schema_dropped(TENANT_DBNAME)
    ensure_default_tenant
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    ensure_default_tenant
    DatabaseCleaner.start
    switch_to_rspec_tenant_db
  end

  config.after(:each) do
    Apartment::Tenant.reset
    DatabaseCleaner.clean
  end

  config.after(:each, js: true) do
    n = TENANT_DBNAME
    if schema_exists?(n)
      Apartment::Tenant.switch(n)
      DatabaseCleaner.clean_with(:truncation)
      Apartment::Tenant.reset
    end
  end
end
