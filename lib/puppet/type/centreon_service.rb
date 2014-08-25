Puppet::Type.newtype(:centreon_service) do
    @doc = "Centreon Service - Puppet Management Interface with Centreon CLAPI"

    ensurable

    newparam(:name) do
      desc "Name of the service"
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

    newparam(:hostname) do
      desc "Hostname"
    end

    newparam(:description) do
      desc "Description of the service"
    end

    newproperty(:check_command) do
      desc "Name of the check command"
    end

    newparam(:template) do
      desc "Service Template to use"
    end

end