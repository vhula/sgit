# `sgit`

Shortcuts for common `git` commands and a tool for managing git configuration easily

## Table of contents
  * [Table of Contents](#table-of-contents)
  * [Installation](#installation)
    * [Manual Installation](#manual-installation)
  * [Predefined Shortcuts and Aliases for Common Commands](#predefined-shortcuts-and-aliases-for-common-commands)
  * [`sgit` Usage](#sgit-usage)
    * [sgit Commands](#sgit-commands)
    * [List Command](#list-command)
    * [Configuration Command](#configuration-command)
      * [One-Time Configuration](#one-time-configuration)
      * [Generic Configuration](#generic-configuration)
      * [Alias Configuration](#alias-configuration)
  * [Contributions and Development](#contributions-and-development) 

## Installation

### Manual Installation

Follow these steps to install `sgit` manually:
1. clone this repository
2. add `<cloned directory>/scripts` directory to your `$PATH`

    Assuming that this repository cloned into `/usr/local/bin/sgit/` directory:
    
    `export PATH=$PATH:/usr/local/bin/sgit/scripts`

## Predefined Shortcuts and Aliases for Common Commands

| Alias      | Shortcut       | Command                    | Description |
| ---------- | -------------- | -------------------------- | ----------- |
| `s`        | `gits`         | `git status`                   |             |
| `pr`       | `gitpr`        | `git pull --rebase`            |             |
| `c`        | `gitc`         | `git commit`                   |             |
| `cp`       | `gitcp`        | `git commit --amend`           | Amend previous commit            |
| `cpn`      | `gitcpn`       | `git commit --amend --no-edit` | Amend previous commit without editing the commit message |
| `ch`       | `gitch`        | `git checkout`                 |             |
| `f`        | `gitf`         | `git fetch`                    |             |
| `m`        | `gitm`         | `git merge`                    |             |
| `aa`       | `gitaa`        | `git add --all`                | Add all changed files |
| `ac`       | `gitac`        | `git add .`                    | Add current directory to staged area |
| `sr`       | `gitsr`        | `git reset HEAD`               |             |
| `sr1`      | `gitsr1`       | `git reset HEAD~1`             |             |
| `sr2`      | `gitsr2`       | `git reset HEAD~2`             |             |
| `hr`       | `githr`        | `git reset --hard HEAD`        |             |
| `hr1`      | `githr1`       | `git reset --hard HEAD~1`      |             |
| `hr2`      | `githr2`       | `git reset --hard HEAD~2`      |             |
| `l`        | `gitl`         | `git log`                      |             |
| `l1`       | `gitl1`        | `git log -1`                   |             |
| `l2`       | `gitl2`        | `git log -2`                   |             |
| `l3`       | `gitl3`        | `git log -3`                   |             |
| `l4`       | `gitl4`        | `git log -4`                   |             |
| `l5`       | `gitl5`        | `git log -5`                   |             |

## `sgit` Usage

<details>
 <summary>Common usage</summary>
<p>

    $sgit [COMMAND] [ARGUMENT VALUE]... [OPTION]...

1. Help

    `$sgit --help`
    
    ```
    Usage: sgit <command> [ARGUMENT VALUE]... [OPTION]...
    
    Global options:
            -h, --help                      print usage
            -v, --verbose                   verbose mode
            -q, --quiet                     only errors are printed
            --silent                        all messages are disabled
    
    Available commands:
            list                            prints lists of different objects(tools, git aliases)
            configure                       configures git aliases, username, email, etc.
            Execute 'sgit <command> --help' for more information about a command
    ```

</p>
</details>

### sgit Commands

| Command      | Description                |
| ------------ | -------------------------- |
| `list`       | Print different lists (list of available commands, pre-defined aliases)         |
| `configure`  | Configures multiple things in git        |

### List Command

1. List all pre-defined aliases:

    `$sgit list --aliases`
    
<details>
 <summary>Result of the command</summary>
<p>

    Aliases...
    ----------
    s=status
    pr=pull --rebase
    c=commit
    cp=commit --amend
    cpn=commit --amend --no-edit
    ch=checkout
    f=fetch
    m=merge
    aa=add --all
    ac=add .
    sr=reset HEAD
    sr1=reset HEAD~1
    sr2=reset HEAD~2
    hr=reset --hard HEAD
    hr1=reset --hard HEAD~1
    hr2=reset --hard HEAD~2
    l=log
    l1=log -1
    l2=log -2
    l3=log -3
    l4=log -4
    l5=log -5

</p>
</details>

2. List commands

    `$sgit list --commands`
    
<details>
 <summary>Result of the command</summary>
<p>

    Commands...
    -----------
    list
    configure
    
    Execute 'sgit <command> --help' for details
    
</p>
</details>


### Configuration Command

#### One-Time Configuration

To configure git username, email, default editor and pre-defined aliases:

    $sgit configure --alias --git-alias --global --username "Your Name" --email "Your Email" --editor vim
    
This command results into:
    
    [core]
        editor = vim
    ...
    [user]
            name = Your Name
            email = Your Email
    [alias]
            s = status
            pr = pull --rebase
            c = commit
            cp = commit --amend
            cpn = commit --amend --no-edit
            ...
    ...

#### Generic Configuration

  Append `--global` option if you want to configure git aliases globally.

1. Configure username:

    `$sgit configure --username "<Your Name>"`
    
    `$sgit configure -u "<Your Name>"`
    
2. Configure email:

    `$sgit configure --email "<Your Email>"`
    
    `$sgit configure -e "<Your Email>"`
    
  Multiple options can be applied simultaneously:

   `$sgit configure -u "<Your Name>" -e "<Your Email>" --editor "vim"`

#### Alias Configuration
1. Configure git aliases:

    `$sgit configure --git-alias`
    
2. Configure shortcuts:

    `$sgit configure --alias`
    
3. Remove configuration:

    `$sgit configure --alias --unset`
    
    `$sgit configure --git-alias --unset`

## Contributions and Development

### Contribution

1. Create an issue (what you want to see in this tool)
2. Assign any issue to yourself
3. Create a pull request

### Development

What suites you best :)