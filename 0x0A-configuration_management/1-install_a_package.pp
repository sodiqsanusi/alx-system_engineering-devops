# Install a Python package using a Puppet manifest

package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  name     => 'flask',
}
