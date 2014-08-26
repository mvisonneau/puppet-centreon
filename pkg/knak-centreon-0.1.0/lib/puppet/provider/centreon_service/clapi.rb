Puppet::Type.type(:centreon_service).provide(:clapi) do
  desc = "Provision Centreon Services through CLAPI"

  def exists?
  	output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o SERVICE -a SHOW -v "#{@resource[:description]}" | grep "#{@resource[:hostname]}"`
  	if output.to_s.lines.count != 1
  		:false
  	else
  		:true
  	end
  end

  def create
  	output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o SERVICE -a ADD -v "#{@resource[:hostname]};#{@resource[:description]};#{@resource[:template]}"`
  	:true
  end

  def destroy
    output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o SERVICE -a DEL -v "#{@resource[:hostname]};#{@resource[:description]}"`
    :true
  end

  # Property : check_command
  def check_command
    output = `grep "SERVICE;setparam;#{@resource[:hostname]};#{@resource[:description]};check_command;#{@resource[:check_command]}" #{@resource[:clapi_export_file]}`
    if output.to_s.lines.count >= 1
      @resource[:check_command]
    else
      :absent
    end
  end

  def check_command=(value)
    output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o SERVICE -a setparam -v "#{@resource[:hostname]};#{@resource[:description]};check_command;#{@resource[:check_command]}"`
  end

  # Property : enabled
  def enabled
    output = `grep "SERVICE;setparam;#{@resource[:hostname]};#{@resource[:description]};service_activate;0" #{@resource[:clapi_export_file]}`
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
    output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o SERVICE -a setparam -v "#{@resource[:hostname]};#{@resource[:description]};service_activate;#{clapi_value}"`
  end

end