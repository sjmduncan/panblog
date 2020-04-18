# Panblog

[Pandoc](https://pandoc.org/) + bash + git = blog.

## Why?

There are lots of [static site generators](https://www.staticgen.com/) but...

- Lots of them are complicated, have dependencies
- Don't care about analytics/CMS/comments/anything that's not static
  HTML/CSS(/mathjax)
- [they weren't invented here](https://en.wikipedia.org/wiki/Not_invented_here)
- Pandoc is already everywhere that I do work

So probably don't use this.

## Requirements

- Pandoc
  - pandoc-citeproc (optional) for bibtex citations with  \[@cite-key\] 
- bash
- git (+ `gitolite` or whatever you use to manage remote repositories)
- ssh
- A server to host stuff (unless you just want to turn `.md` into `.html` with an index page locally
- rsync (optional, if you have lots of media files this will make publishing/generating previews faster)

## Setup

```BASH
git clone <blah>
cd panblog`
./install.sh
```

This'll put the `pb` and `pb-create` scripts in `~/.local/bin` and add that to
your path (and also some template stuff in ~/.local/share/panblog`.

## Using

Run `pb help` for what pb can do. 

```
$ pb help
panblog version 0.1

valid commands:
   [w|write]   - create a new blog entry
   [e|edit]    - edit a draft entry
   [r|rewrite] - edit a published (non-draft) entry
   pub         - publish all articles to preview dir
   push        - publish stuff to production server via git push
   [h|-h|help] - show this message
```

Run `pb-create` from inside a new blog directory  and follow the prompts to get bloggin'


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

Edit `pb.conf` in your blog directory to change pb options. 

```bash
pb_title="Panblog - blog with pandoc"
pb_author="Stu"

# Prefix articles with date/time (0=no date, 1=date, 2=date and time)
pb_usedate=1

# set to 1 for more output
pb_verbose=0

pb_srcdir="__SRCDIR__"
pb_reltempldir="$pb_srcdir/templates/"
pb_relmediadir="$pb_srcdir/media/"

pb_prev_pubroot="__PREVDIR__"
pb_prod_pubroot="__PRODDIR__"
pb_prod_user="__PBPRDUSR__"
pb_prod_group="__PBPRDGRP__"

pb_tmpl_entry="$pb_reltempldir/template_entry.md"
pb_tmpl_entry_html="$pb_reltempldir/template_entry.html"
pb_tmpl_index="$pb_reltempldir/template_index.md"
pb_tmpl_index_html="$pb_reltempldir/template_index.html"
pb_temp_index="/tmp/index.md"

pb_pandoc_args="--standalone --css=style.css --listings --mathjax --filter pandoc-citeproc"

```

After you write some junk run `pb pub` to generate a preview on whatever machine you're working on. 
Then do `git add .` and `git push` 

## Publishing

1. Set up your remote repository (use `git init --bare`, `gitolite`, `gitlab`, or whatever tickles your fancy, it's just gotta be on the whatever machine serves the blog)
2. Copy `post-recieve` into the `hooks` directory (on the server)
3. Make sure the copied version of `post-receive` is writeable (`chmod a+x` should do)
3. Make sure the `prod\_*` variables are set correctly in `pb.conf`
4. Do `get remote add`
5. Do `git add .`
6. Do `git commit -m "some commit message"`
7. Do `git push`

You'll see some non-standard output about `UP` and copying files, and maybe something that looks like the end of some rsync output (if the remote machine has rsync). 

And hopefully you should have a live blog.
