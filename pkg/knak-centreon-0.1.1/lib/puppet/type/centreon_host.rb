Puppet::Type.newtype(:centreon_host) do
    @doc = "Centreon Host - Puppet Management Interface with Centreon CLAPI"

    ensurable

    newparam(:name) do
      desc "Name of the host"
    end

    newparam(:clapi_binaries) do
      desc "Path of the CLAPI binaries."
    end

    newparam(:clapi_username) do
      desc "The CLAPI username."
    end

    newparam(:clapi_password) do
      desc "The CLAPI username password."
    end

    newparam(:clapi_export_file) do
      desc "The CLAPI export file location."
    end
    
    newparam(:poller_name) do
      desc "Poller name"
    end

    newparam(:alias) do
      desc "Hostname"
    end

    newparam(:address) do
      desc "IP Address"
    end

    newparam(:template) do
      desc "Host template"
    end

    newproperty(:enabled) do
      desc "Activation status of the host"
      newvalues(:true,:false)
      defaultto :true
    end
end