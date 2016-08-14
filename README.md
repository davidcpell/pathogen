# pathogen Cookbook

Use this cookbook to install the Pathogen vim plugin manager.

### Platforms

This cookbook has been tested with the following platforms:

- Ubuntu 16.04
- Ubuntu 14.04
- Centos 7.2

### Prerequisites

The focus of this cookbook is on installing Pathogen and plugins, so it doesn't provide sophisticated recipes for `git` and `vim` itself, for which excellent and detailed cookbooks are already available. With that said, you *can* include barebones package-based recipes from within this cookbook if you don't need anything special:

```ruby
include_recipe 'pathogen[vim]'
include_recipe 'pathogen[git]'
```

### Attributes

- `node['user']` - Specify the name of the user who will own the Pathogen installation. The necessary directory structure will be created in this user's `$HOME`. 

### Resources

- `pathogen_plugin` - This resource wraps `git` and can be used to install plugins to your user's `$HOME/.vim/bundle` directory. To use it, pass the name of the plugin as the `name` attribute and the GitHub user/organization as the `org` attribute:

    ```ruby
    pathogen_plugin 'ctrlp.vim' do
      org 'ctrlpvim'
    end
    ```

### Usage

To install Pathogen, add `recipe[pathogen]` to your run list or include the default recipe in recipe that is in your run list.

To install plugins, use the above-mentioned `pathogen_plugin` LWRP in a recipe that is in your run list.

## Contributing

Please open an issue if you find a bug. Pull requests are also welcome. When submitting pull requests, please try to abide by the following guidelines:

1. Keep changes as small as possible
2. Rebase and squash extraneous commits whenever possible
3. Use detailed commit messages
4. Don't modify version information
