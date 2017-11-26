# `sgit`

This is a tool for managing git configuration easily

## Table of contents
  * [Table of contents](#table-of-contents)
  * [Installation](#installation)
    * [Manual installation](#manual-installation)
  * [Usage](#usage)
    * [Shortcuts for common commands](#shortcuts-for-common-commands)
    * [sgit tool](#sgit-tool)
      * [One-time configuration](#one-time-configuration)
      * [Generic configuration](#generic-configuration)
      * [Alias configuration](#alias-configuration)
        * [Supported aliases](#supported-aliases)
  * [Contributions and Development](#contributions-and-development) 

## Installation

### Manual installation

Follow these steps to install `sgit` manually:
1. clone this repository
2. add `<cloned directory>/scripts` directory to your `$PATH`

    Assuming that this repository cloned into `/usr/local/bin/sgit/` directory:
    
    `export PATH=$PATH:/usr/local/bin/sgit/scripts`

## Usage

<details>
 <summary>Common usage</summary>
<p>

    $sgit [ARGUMENT VALUE]... [OPTION]...

1. Help

    `$sgit --help`
    
    ```
    Usage: sgit [ARGUMENT VALUE]... [OPTION]...
    All options are applied globaly by default (git config --global)
    
    Arguments:
            -u, --username                  name of the user for git env
            -e, --email                     email of the user for git env
            --editor                        git editor
    Options:
            -h, --help                      print usage
            -c, --configure                 configure default aliases
            --global-off                    apply configuration for the current user only
    Commands:
    Arguments, options, and commands that are not listed below, are ignored by the commands
            list-aliases                    list supported aliases
    ```

</p>
</details>

### Shortcuts for common commands

| Shortcut   | Command                    | Description |
| ---------- | -------------------------- | ----------- |
| `sgit-s`   | `git status`               |             |    
| `sgit-pr`  | `git pull --rebase`        |             | 

### sgit tool

#### One-time configuration

To configure git username, email, default editor and pre-defined aliases:

    $sgit --username "Your Name" --email "Your Email" --editor vim --configure
    
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

#### Generic configuration
1. Configure username:

    `$sgit --username "<Your Name>"`
    
    `$sgit -u "<Your Name>"`
    
2. Configure email:

    `$sgit --email "<Your Email>"`
    
    `$sgit -e "<Your Email>"`
    
  Multiple options can be applied simultaneously:

   `$sgit -u "<Your Name>" -e "<Your Email>" --editor "vim"`

#### Alias configuration
1. Configure all supported aliases:

    `$sgit --configure`
    
    `$sgit -c`

##### Supported aliases

(More will be added later)

| Alias      | Command                    | Description |
| ---------- | -------------------------- | ----------- |
| `s`        | `status`                   |             |
| `pr`       | `pull --rebase`            |             |
| `c`        | `commit`                   |             |
| `cp`       | `commit --amend`           | Amend previous commit            |
| `cpn`      | `commit --amend --no-edit` | Amend previous commit without editing the commit message |
| `ch`       | `checkout`                 |             |
| `f`        | `fetch`                    |             |
| `m`        | `merge`                    |             |
| `aa`       | `add --all`                | Add all changed files |
| `ac`       | `add .`                    | Add current directory to staged area |
| `sr`       | `reset HEAD`               |             |
| `sr1`      | `reset HEAD~1`             |             |
| `sr2`      | `reset HEAD~2`             |             |
| `hr`       | `reset --hard HEAD`        |             |
| `hr1`      | `reset --hard HEAD~1`      |             |
| `hr2`      | `reset --hard HEAD~2`      |             |
| `l`        | `log`                      |             |
| `l1`       | `log -1`                   |             |
| `l2`       | `log -2`                   |             |
| `l3`       | `log -3`                   |             |
| `l4`       | `log -4`                   |             |
| `l5`       | `log -5`                   |             |

#### Commands
1. List all pre-defined aliases:

    `$sgit list-aliases`
    
<details>
 <summary>Result of the command</summary>
<p>

    Supported aliases list:

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

## Contributions and Development

### Contribution

1. Create an issue (what you want to see in this tool)
2. Assign any issue to yourself
3. Create a pull request

### Development

What suites you best :)