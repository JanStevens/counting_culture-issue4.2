# == Schema Information
#
# Table name: public.tenants
#
#  id         :integer          not null, primary key
#  name       :string
#  db_name    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tenant < ActiveRecord::Base
  after_create :create_tenant_db
  after_destroy :drop_tenant_db

  def create_tenant_db
    ensure_tenant_schema_exists
  end

  private

  def schema_exists?
    Apartment.connection.schema_exists?(db_name)
  end

  # Ensures the schema for this Tenant exists
  # @return [undefined]
  #
  def ensure_tenant_schema_exists
    logger.info "Creating new schema '#{db_name}' ..."
    if schema_exists?
      logger.info "Schema '#{db_name}' already existed!"
    else
      Apartment::Tenant.create(db_name)
    end
  rescue Apartment::SchemaExists => e
    logger.info "#{e.class.name}: Schema '#{db_name}' already existed!"
  end

  def drop_tenant_db
    logger.info "dropping schema #{db_name}"
    Tenant.connection.execute "DROP SCHEMA IF EXISTS #{db_name} CASCADE;"
  end
end
