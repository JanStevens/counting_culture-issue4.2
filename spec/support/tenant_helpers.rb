module TenantHelpers
  def rspec_tenant_db_name
    TENANT_DBNAME
  end

  def switch_to_rspec_tenant_db
    switch_to_db(rspec_tenant_db_name)
  end

  def rspec_tenant
    Tenant.where(db_name: rspec_tenant_db_name).first!
  end

  # Handy for logging/debugging
  def current_db_name
    Apartment::Tenant.current_tenant
  end

  def switch_to_db(_db_name)
    Apartment::Tenant.switch(rspec_tenant_db_name)
  end
end
include TenantHelpers
