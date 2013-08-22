hadupils Cookbook
=================

This cookbook installs the hadupils gem (http://github.com/ethanrowe/hadupils)
and provides a mechanism for the easy installation of wrapper scripts
that use it.

The purpose of this is to make hadoop-based apps easier to configure
by using hadupils to dynamically assemble configuration based on
assets located at convention-determined points in the filesystem.


Requirements
------------

#### gems
- `hadupils` - basically everything is oriented around this gem.

Attributes
----------

#### hadupils::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['hadupils']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### hadupils::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `hadupils` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[hadupils]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. File an issue with the canonical repository
3. Create a named feature branch referencing that issue
4. Write your change
5. Write tests for your change (if possible within existing test infra)
6. Run the tests, ensuring they all pass
7. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Ethan Rowe
License: MIT
