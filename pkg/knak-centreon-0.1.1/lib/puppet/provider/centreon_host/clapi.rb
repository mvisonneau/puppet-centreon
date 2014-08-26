Puppet::Type.type(:centreon_host).provide(:clapi) do
  desc = "Provision Centreon Hosts through CLAPI"
  
  def exists?
  	output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o HOST -a SHOW -v "#{@resource[:alias]}"`
  	if output.to_s.lines.count < 2
  		:false
  	else
  		:true
  	end
  end

  def create
  	output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o HOST -a ADD -v "#{@resource[:name]};#{@resource[:alias]};#{@resource[:address]};#{@resource[:template]};#{@resource[:poller_name]};Linux"`
  	:true
  end

  def destroy
    output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o HOST -a DEL -v "#{@resource[:name]}"`
    :true
  end

  # Property : enabled
  def enabled
    output = `grep "HOST;setparam;#{@resource[:alias]};host_activate;0" #{@resource[:clapi_export_file]}`
    if output.to_s.lines.count >= 1
      :false
    else
      :true
    end
  end

  def enabled=(value)
    if @resource[:enabled] == :true
      clapi_value = 1
    else
      clapi_value = 0
    end
    output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o HOST -a setparam -v "#{@resource[:alias]};host_activate;#{clapi_value}"`
  end

end