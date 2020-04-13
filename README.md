# Panblog

[Pandoc](https://pandoc.org/) + bash + git = blog anywhere.

## Why?

There are lots of [static site generators](https://www.staticgen.com/). Don't like them, too complicated, don't need most of the analytics/cms/third-party-integration that a lot of them provide, [they weren't invented here](https://en.wikipedia.org/wiki/Not_invented_here)), and I already have pandoc pretty much everwhere I work.

## Requirements

- [pandoc]()
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

This'll put `pb` abd `pb-create` in `~/.local/bin` and add it to your `PATH` in `~/.bashrc`, `pb` is mostly how you interact with panblog:

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
Creating a new blog in /home/stu/Projects/pantest

What's the title?
Panblog Blog

Who's the author?
Stu

What's the source subdirectory?
src/

Where should previews be published?
/home/stu/Documents/blog_preview

Where to pub on production machine?
/var/www/blog

$EDITOR is vim (you can change this in pb.conf later)

Production user (probably git)?
git

Production usergroup (probably www-data)?
www-data

Initialized empty Git repository in /home/stu/Dropbox/Projects/pantest/.git/

Where's your remote URL?
gitolite:blog_src.git
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


