require 'chefspec'

shared_examples 'empty command' do |path|
  it 'should use the path basename for the command' do
    command = File.basename(path)
    expect(subject).to create_file_with_content path,
                                                %r{^hadupils #{command} \$@$}
  end
end

describe 'hadupils_script resource' do
  let :chef_run do
    ChefSpec::ChefRunner.new(:step_into => ['hadupils_script'])
  end

  let :attr_setter do
    chef_run.node.set['hadupils']['resource_test']
  end

  subject do
    chef_run.converge 'hadupils::resource_test'
  end

  before do
    attr_setter['path'] = '/some/user/bin/wrapper'
    attr_setter['action'] = :create
    attr_setter['command'] = 'some_command'
    attr_setter['owner'] = 'some_owner'
    attr_setter['group'] = 'some_group'
    attr_setter['mode'] = '0777'
  end

  context 'with all attributes specified' do
    it 'should create a wrapper script from template at the specified path' do
      expect(subject).to create_file_with_content '/some/user/bin/wrapper',
                                                  %r{^hadupils some_command \$@$}
    end

    it 'should set path to the specified permissions' do
      file = subject.template '/some/user/bin/wrapper'
      expect(file).to be_owned_by('some_owner', 'some_group')
      expect(file.mode).to eq '0777'
    end
  end

  context 'with an empty command' do
    before do
      attr_setter['path'] = '/my/awesome/script/thingy'
      attr_setter['command'] = ''
    end

    include_examples 'empty command', '/my/awesome/script/thingy'
  end

  context 'with a nil command' do
    before do
      attr_setter['path'] = '/another/awesome/scripty/delight'
      attr_setter['command'] = nil
    end

    include_examples 'empty command', '/another/awesome/scripty/delight'
  end

  context 'with no mode' do
    it 'should default to mode 0555 given nil' do
      attr_setter['mode'] = nil
      file = subject.template '/some/user/bin/wrapper'
      expect(file.mode).to eq '0555'
    end

    it 'should blow up given empty string' do
      attr_setter['mode'] = ''
      expect { subject.template '/some/user/bin/wrapper' }.to raise_error(Chef::Exceptions::ValidationFailed)
    end
  end

  it 'should use the :create action by default' do
    attr_setter['action'] = nil
    expect(subject).to create_file '/some/user/bin/wrapper'
  end

  it 'should delete the file on :delete' do
    attr_setter['action'] = :delete
    expect(subject).to delete_file '/some/user/bin/wrapper'
  end
end
