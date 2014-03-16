nomad.vim
=========

Using Vim in a remote tmux session is very convenient, because you can detach
the running session and resume it later without leaving Vim. This is great in
situations where you login with ssh into your development machine at work or
your server to continue coding after you changed your location.
But suddenly, when you try to access a git+ssh remote (maybe through tpope's
excellent [fugitive](https://github.com/tpope/vim-fugitive) plugin) or access
the `quotestar` or `quoteplus` registers, things won't work as expected because
with a new ssh connection some of your environment variables changed and Vim
doesn't know about it.
Fortunately tmux knows about these changes and this is where the `nomad` plugin
kicks in. It queries tmux for the new values and updates your environment in
Vim.


Installation
------------
If you don't have a preferred installation method, I recommend installing
[pathogen.vim](https://gitub.com/tpope/vim-pathogen), and then simply copy and
paste:

``
cd ~/.vim/bundle
git clone git://github.com/buztard/vim-nomad.git
``

Or for [Vundle](https://github.com/gmarik/vundle) users:

Add `Bundle 'buztard/vim-nomad'` to your `~/.vimrc` and then:

* either within Vim: `:BundleInstall`
* or in your shell: `vim +BundleInstall +qall`

Usage
-----

Just run `:UpdateEnv` when you re-attached your tmux session from a different
ssh connection.

See `:help nomad` for details

