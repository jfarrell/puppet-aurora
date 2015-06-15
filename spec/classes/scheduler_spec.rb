require 'spec_helper'
# '$aurora::owner'= 'aurora'
# '$aurora::owner' = 'aurora'

$default_package = ['aurora-doc','aurora-scheduler','aurora-tools',]
#$default_scheduler_file_attr =

describe 'autofs::scheduler' do
  let (:facts) { { :osfamily => 'Debian', 'aurora_ensure' => '0.9.0' } } # should aurora_ensure be here, or tested

  it { should contain_file('/var/lib/aurora/scheduler/db').with(:ensure => directory).with_params(
    :owner => 'aurora',
    :group => 'aurora',
    :mode => '0644',
    :require => [Package['aurora-scheduler'],
    File['/var/lib/aurora/scehduler']
  ]
  ) }

  it { should contain_file('/var/lib/aurora/scheduler').with(:ensure => directory).with_params(
    :owner => 'aurora',
    :group => 'aurora',
    :mode => '0644',
    :require => Package['aurora-scheduler']
    ) }

    it { should contain_file('/etc/default/aurora-scheduler').with(:ensure => directory).with_content(:source => 'puppet:///aurora/aurora-scheduler.erb').with_params(
      :owner => 'aurora',
      :group => 'aurora',
      :mode => '0644',
      :require => Package['aurora-scheduler']
      ) }


  describe ' by default' do
    let (:facts) { { :manage_package => true } }
    it { should contain_package('default_package').with(:ensure => '0.9.0').with_params(:require => Class['aurora::repo'] ) }
    it { should contain_package('aurora-scheduler') }

    context 'with aurora_ensure = default'
    let (:facts) { { 'aurora_ensure' => '0.9.0'} }
    it  do
       should contain_aurora__version('0.9.0') # not sure that this is the right way to write this
    end

    context 'with aurora_ensure = undef'
    let (:facts) { { 'aurora_ensure' => 'absent'} }
    it  do
       should_not contain_aurora__version('0.9.0') #check syntax
       should_not compile
     end

        context 'with $aurora::master => true'
        let (:facts) { { 'aurora::master' => true } }
        it { should contain_exec('init-mesos-log').with_params({
          :require =>  Package['aurora-scheduler'],
          :notify => Service['aurora-scheduler'],
           command => '/usr/bin/mesos-log initialize --path=/var/lib/aurora/scheduler/db && /bin/chown aurora:aurora /var/lib/aurora/scheduler/db/*',
           :unless => '/usr/bin/test -f /var/lib/aurora/scheduler/db/CURRENT' }) }

        context 'with $aurora::master => false'
        let (:facts) { { 'aurora::master' => false} }
        it { should_not contain_exec('init-mesos-log').with_params({
          :require =>  Package['aurora-scheduler'],
          :notify => Service['aurora-scheduler'],
          command => '/usr/bin/mesos-log initialize --path=/var/lib/aurora/scheduler/db && /bin/chown aurora:aurora /var/lib/aurora/scheduler/db/*',
          :unless => '/usr/bin/test -f /var/lib/aurora/scheduler/db/CURRENT'} ) }

      end
    end


    #should we include context when aurora::master => true in default case, or just its own context/test file?
