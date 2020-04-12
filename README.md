# `panblog`
[Pandoc](https://pandoc.org/) + bash + git = blog from nearly anwyere.


## Why?

Almost everything else seemed more complicated than I needed, but also they [weren't invented here](https://en.wikipedia.org/wiki/Not_invented_here).

## How?


## Requirements

- pandoc
  - pandoc-citeproc (optional) for bibtex citations with  \[@cite-key\] 
- Bash
- git
- ssh

## Using

The expected workflow is

1. Clone a blog-source reository (a bunch of markdown files, pandoc templates, and a `plng_config` file)
2. Use `plng [write|edit|rewrite]` to add/edit markdown files. Or manually modify templates and style files, add images and other media
3. Publish via `git add` and then `git push`

On publication, the checksum of each source/style/media file is recorded and linked to the destination file.
On re-publication the checksum of each source/media/style file is checked against the recorded checksum, so only files which have changed are updated.

## Starting

Clone me:

```bash
git clone https://github.com/sjmduncan/plng.git
```

Create new repo:

```bash
source plng/plng
plng init "Blog Title"
```

This gets you a new blog root (in this case `./Blog_Title') with some pandoc-html templates, a css file, and some markdown templates for what the index page and each entry should contain:

```
Blog_Title/
  .git/
  .gitignore
  plng_config
  src/
    media/
  style/
    style.css
    template_index.md
    tempalte_index.html
    template_entry.md
    template_entry.html
```

The blog root is also a git repository, it's expected that blogs are published by pushing to a git repository on the production server, which will run a git hook to generate the files on the server.

New markdown files go in `src/`, `src/media` is for images/video/other media, and `plng_config` stores metadata and where stuff gets published:

```BASH

export plng_title="Blog_Title"
export plng_author="Author"

export plng_prev_pubroot="$HOME/site_preview/$plng_title/"
export plng_prod_pubroot="/var/www-data/$plng_title/"

# Un-comment this to use vim (and/or replace vim with whatever editor you want to use)
#export EDITOR=vim
```

The title and author variables are self explanatory, and the `pubroot`s define where generated files are placed when you run `plng preview` - the `prev` root is where files go when you run it locally (the 'preview' root), and the `prod` version is used when the git hook invokes `plng pub_prod`

Use `plng` by invoking it inside the blog-root directory with some arguments:

`plng write` - write a new article  
`plng edit` - edit a draft article  
`plng rewrite` - rewrite history  
`plng preview` - generate a preview wherever `plng_prev_pubroot` points to  
`plng pub` - add/push any non-draft articles to the production repository

## On the Server

You need a git repository ([I choose gitolite to manage these](https://gitolite.com)), with the post-receive hook installed
