# pathogen Cookbook

Use this cookbook to install the Pathogen vim plugin manager.

### Platforms

This cookbook has been tested with the following platforms:

- Ubuntu 14.04
- Centos 7.2

### Prerequisites

The focus of this cookbook is on installing Pathogen and plugins, so it doesn't provide sophisticated recipes for `git` and `vim` itself, for which excellent and detailed cookbooks are already available. With that said, you *can* include barebones package-based recipes from within this cookbook if you don't need anything special:

```ruby
include_recipe 'pathogen[git]'
include_recipe 'pathogen[vim]'
```

### Attributes

- `node['pathogen']['install_path']` - Specify the directory where pathogen should be installed. Defaults to `'/root/.vim`.
- `node['pathogen']['vimrc_path']` - Specify the location of your user's `.vimrc` file. Defaults to `'/root/.vimrc'`.

### Resources

- `pathogen_plugin` - This resource wraps `git` and can be used to install plugins to `node['pathogen']['install_path']/bundle`. To use it, pass the name of the plugin as the `name` attribute and the GitHub user/organization as the `github_org` attribute:

    ```ruby
    pathogen_plugin 'ctrlp.vim' do
      github_org 'ctrlpvim'
    end
    ```

### Usage

To install Pathogen, add `recipe[pathogen]` to your run list or include the default recipe in recipe that is in your run list. If you aren't using some other source to install `git` and `vim`, add those recipes before the default pathogen recipe.

To install plugins, use the above-mentioned `pathogen_plugin` LWRP in a recipe that is in your run list.

## Contributing

Please open an issue if you find a bug. Pull requests are also welcome. When submitting pull requests, please try to abide by the following guidelines:

1. Keep changes as small as possible
2. Rebase and squash extraneous commits whenever possible
3. Use detailed commit messages
4. Don't modify version information
