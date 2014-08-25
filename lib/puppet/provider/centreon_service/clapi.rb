Puppet::Type.type(:centreon_service).provide(:clapi) do
  desc = "Provision Centreon Services through CLAPI"

  def exists?
  	output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o SERVICE -a SHOW -v "#{@resource[:description]}" | grep "#{@resource[:hostname]}"`
  	if output.to_s.lines.count != 1
  		return false
  	else
  		return true
  	end
  end

  def create
  	output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o SERVICE -a ADD -v "#{@resource[:hostname]};#{@resource[:description]};#{@resource[:template]}"`
  	return true
  end

  def destroy
  	output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o SERVICE -a DEL -v "#{@resource[:hostname]};#{@resource[:description]}"`
  	return true
  end

  # Return the mode as an octal string, not as an integer.l
  def check_command
    output = `grep "SERVICE;setparam;#{@resource[:hostname]};#{@resource[:description]};check_command;#{@resource[:check_command]}" #{@resource[:clapi_export_file]}`
    if output.to_s.lines.count >= 1
      @resource[:check_command]
    else
      :absent
    end
  end

  # Set the file mode, converting from a string to an integer.
  def check_command=(value)
    output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o SERVICE -a setparam -v "#{@resource[:hostname]};#{@resource[:description]};check_command;#{@resource[:check_command]}"`
  end

end