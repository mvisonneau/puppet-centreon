Puppet::Type.type(:centreon_host).provide(:clapi) do
  desc = "Provision Centreon Hosts through CLAPI"

  def exists?
  	output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o HOST -a SHOW -v "#{@resource[:alias]}"`
  	if output.to_s.lines.count < 2
  		return false
  	else
  		return true
  	end
  end

  def create
  	output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o HOST -a ADD -v "#{@resource[:name]};#{@resource[:alias]};#{@resource[:address]};#{@resource[:template]};#{@resource[:poller_name]};Linux"`
  	return true
  end

  def destroy
  	output = `cd #{@resource[:clapi_binaries]} && ./centreon -u#{@resource[:clapi_username]} -p#{@resource[:clapi_password]} -o HOST -a DEL -v "#{@resource[:name]}"`
  	return true
  end
end