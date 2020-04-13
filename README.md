# `panblog`

[Pandoc](https://pandoc.org/) + bash + git = panblog.


## Why?

Pandoc is really good, works for mathjax and via the `pandoc-citeproc` filter can do academic style citations from `bibtex` files that I already have.

Other things seemed more complicated than I needed, and besides [I didn't invent them](https://en.wikipedia.org/wiki/Not_invented_here).

## Requirements

- pandoc
  - pandoc-citeproc (optional) for bibtex citations with  \[@cite-key\] 
- bash
- git (`gitolite` is recommended for managing the remote repository)
- ssh

## Setup

```BASH
git clone <blah>
cd panblog`
./install.sh
```

This provides two commands: `pb-create` for creating a new blog root, and `pb` which must be invoked from within a blog root (i.e. a folder that contains a valid `pb.conf` file) and lets you work on the blog:

```
$ pb help
panblog version 0.1

valid commands:
   write   - create a new blog entry
   edit    - edit a draft entry
   rewrite - edit a published (non-draft) entry
   pub     - publish all articles to preview dir
   push    - publish stuff to production server via git push
   help    - show this message

```

## Using

Create a blog root folder and invoke `pb-create` inside it:


```BASH
$ mkdir -p Projects/blog
$ cd Projects/blog
$ pb-create 

pandoc 2.9.2.1
git version 2.17.1
panblog version 0.1
Creating a new blog in /home/stu/Projects/blog

What's the title?
Panblog - blog with pandoc

Who's the author?
Stu

What's the source subdirectory?
./

Where should previews be published?
$HOME/Documents/blog_preview

Where to publish on production server?
/var/www-data/blog/

Initialized empty Git repository in /home/stu/Projects/blog/.git/
Where's your remote git repository
ssh://git@host.tld/blog_src.git

```

You can leave the last two prompts blank if you don't have a remote repository/production server yet, you can use `git remote add` and update the where-to-publish for the server in `pb.conf` later.

Run 

## Configuring

`pb-create` creates a `pb.conf` file which contains a little metadata and the locations of various source and publication pahts.
**Note** if you change these values manually the directories **must** have a trailing slash.

```bash
pb_title="Panblog - blog with pandoc"
pb_author="Stu"

pb_srcdir="./"
pb_styledir="$pb_srcdir/style/"
pb_mediadir="$pb_srcdir/media/"

pb_prev_pubroot="$HOME/Documents/blog_preview/"
pb_prod_pubroot="/var/www-data/blog/"

```


