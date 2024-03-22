# Install a Python package using a Puppet manifest

package { 'installFlaskPackage':
  ensure   => '2.1.0',
  name     => 'flask',
  provider => 'pip3',
}
