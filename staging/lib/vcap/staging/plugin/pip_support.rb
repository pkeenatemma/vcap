module PipSupport

  REQUIREMENTS_FILE = 'app/requirements.txt'

  def uses_pip?
    File.exists?(File.join(source_directory, REQUIREMENTS_FILE))
  end

  # PEP 370 - user install area
  def user_base
    File.join(destination_directory, 'python')
  end

  def install_requirements(packages)
    ENV['PATH'] = "#{ENV['PATH']}:/usr/bin"
    packages.each do |package|
        system "pip install --user #{package} >> logs/startup.log 2>&1"
    end
    system "pip install --user -r #{REQUIREMENTS_FILE} >> ../logs/startup.log 2>&1"
  end

  def setup_python_env
    cmds = [
            'DIR="$( cd "$( dirname "$0" )" && pwd )"',
            "export PYTHONUSERBASE=$DIR/python"
            "export PATH=$PATH:/usr/bin"
           ]
    cmds.join("\n")
  end

end
