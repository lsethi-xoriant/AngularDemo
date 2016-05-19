class ProvidersController < BaseController

	before_filter :find_provider, only: [:edit, :update, :destroy, :show]
	add_breadcrumb "Home", :root_path
	
	def index
		add_breadcrumb "Providers", providers_path
		@providers = current_account.providers
	end

	def new
		@provider = Provider.new
		@provider.build_contact contactable_type: 'Provider'
		@provider.build_address		
	end

	def create
		@provider = Provider.new(provider_params)
		if @provider.save
			redirect_to providers_path, notice: 'Provider successfully created.'
		else
			render action: :new
		end
	end

	def edit
		add_breadcrumb "Providers", providers_path
		add_breadcrumb "Edit Provider"
	end

	def update
	end

	def destroy
	end

	private

	def find_provider
		@provider = current_account.providers.find_by(id: params[:id])
	end

	def provider_params
		params.require(:provider).permit(:clinic_id, :signature_name, :provider_type_code, :tax_uid, :upin_uid, :nycomp_testify, :npi_uid, contact_attributes: [:id, :first_name, :last_name, :phone1, :fax1, :email1, :notes])
	end

end