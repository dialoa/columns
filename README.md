Columns
=======

Multiple columns support in `pandoc`'s markdown.

Introduction
------------

This Lua filter for `pandoc` provides multicolumn support in
`pandoc`'s markdown for outputs in `html` and LaTeX/PDF. It supports
several markdown syntaxes, explicit column breaks, spanning elements, customisation and nesting. Html output relies on [CSS Multi-column layout](https://drafts.csswg.org/css-multicol) and LaTeX/PDF outputs on the [`multicol` LaTeX package](https://www.ctan.org/pkg/multicol).

Limitations: in `html` output, support is limited to recent
browsers and variable across browsers.

This document also serves as a test document.

Pre-requistes
-------------

Copy the file `columns.lua` in your working folder or in `pandoc`'s
`filter` folder. Called from the command line:

~~~~{.bash}
pandoc --lua-filter columns.lua SOURCE.md -o DESTINATION.html

pandoc -L columns.lua SOURCE.md -t latex
~~~~

Or from the `filters` field in a `pandoc` defaults file. See the
[`pandoc` documentation](https://pandoc.org/MANUAL.html) for further
details.

Basic usage
-----------

### Columns

In `pandoc` markdown source specify a multicolumn section as
follows:

```markdown
::: columns

...content that will be spread over several columns...

:::
```

This is based on the [`fenced_div` syntax of `pandoc`'s'
markdown](https://pandoc.org/MANUAL.html#divs-and-spans). At least
three consecutive colons are needed, both at the beginning and at
then end of your multi-column section (even if it runs until the
end of your document). But more than three are fine:

```markdown
::: columns ::::::

...content that will be spread over several columns...

::::::::::::::
```

As we'll see below, if the section has more than a single attribute
(here, `columns`), we specify them within curly brackets and `columns`
should be preceded by a dot, as in:

```markdown
::::: {.columns .someattribute property=value}

...content that will be spread over several columns...

:::::
```


The filter will render this section as a multicolumns layout in `html` and
LaTeX, as illustrated below:

::: columns

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a ante
in mi ornare volutpat sed sit amet diam. Nullam interdum erat a augue
faucibus, nec tempus tortor sagittis. Aenean imperdiet imperdiet
dignissim. Nam aliquam blandit ex, sed molestie nibh feugiat ac. Morbi
feugiat convallis semper. Ut et consequat purus. Fusce convallis
vehicula enim in vulputate. Curabitur a augue arcu. Mauris laoreet
lectus arcu, sed elementum turpis scelerisque id. Etiam porta turpis
quis ipsum dictum vulputate. In ut convallis urna, at imperdiet nunc.
Cras laoreet, massa lobortis gravida egestas, lacus est pellentesque
arcu, imperdiet efficitur nibh dolor vel sapien. Sed accumsan
condimentum diam non pellentesque.

Vestibulum cursus nisi risus, sit amet consectetur massa suscipit nec.
Sed condimentum, est id iaculis ornare, purus risus finibus felis,
posuere congue est nibh eget dui. Maecenas orci erat, commodo auctor
justo quis, vestibulum mollis ex. Vivamus sed bibendum turpis. Donec
auctor, leo a cursus efficitur, quam urna dignissim enim, viverra
condimentum orci est non sem. Donec ac viverra nisl. Suspendisse ac
auctor massa. Mauris porttitor purus vel velit vehicula, sed efficitur
odio lacinia. Fusce sed odio arcu. Ut rhoncus lacus vel magna interdum
tincidunt. Nunc imperdiet finibus tincidunt.

:::

### Specifying the number of columns

By default you get two columns. Alternatively, you can specify the desired
number of columns in various ways:

```markdown
::: twocolumns

::: three-columns

::: five_columns

::: {.columns column-count=3}

```

### Customizing the gap and rule between columns

The gap and rule between columns can be customized too. The gap is
specified with a `columngap` (or `column-gap` or `columnsep` or
`column-sep`) attribute. The rule is specified with a `column-rule`
(or `columnrule`) attribute using CSS syntax.

```markdown
::: {.columns columngap=3em column-rule="1px solid black"}

::: {.threecolumns columngap=4em column-rule="3pt solid blue"}

```

Here is an illustration:

::: {.threecolumns columngap=4em column-rule="3pt solid blue"}

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a ante
in mi ornare volutpat sed sit amet diam. Nullam interdum erat a augue
faucibus, nec tempus tortor sagittis. Aenean imperdiet imperdiet
dignissim. Nam aliquam blandit ex, sed molestie nibh feugiat ac. Morbi
feugiat convallis semper. Ut et consequat purus. Fusce convallis
vehicula enim in vulputate. Curabitur a augue arcu. Mauris laoreet
lectus arcu, sed elementum turpis scelerisque id. Etiam porta turpis
quis ipsum dictum vulputate. In ut convallis urna, at imperdiet nunc.
Cras laoreet, massa lobortis gravida egestas, lacus est pellentesque
arcu, imperdiet efficitur nibh dolor vel sapien. Sed accumsan
condimentum diam non pellentesque.

Vestibulum cursus nisi risus, sit amet consectetur massa suscipit nec.
Sed condimentum, est id iaculis ornare, purus risus finibus felis,
posuere congue est nibh eget dui. Maecenas orci erat, commodo auctor
justo quis, vestibulum mollis ex. Vivamus sed bibendum turpis. Donec
auctor, leo a cursus efficitur, quam urna dignissim enim, viverra
condimentum orci est non sem. Donec ac viverra nisl. Suspendisse ac
auctor massa. Mauris porttitor purus vel velit vehicula, sed efficitur
odio lacinia. Fusce sed odio arcu. Ut rhoncus lacus vel magna interdum
tincidunt. Nunc imperdiet finibus tincidunt.

:::

### Explicitly specifying column breaks

Column breaks can be explicitly specified. This can be done using
`\columnbreak` or a `columnbreak` (or `column-break`) section.

```markdown
::: columns

This content is in a first column.

\columnbreak

This content is in a second column.

:::: columnbreak
::::

This content is in a third column.

:::: column-break
::::

This content is in a fourth column.

:::
```

The result is:

::: columns

This content is in a first column.

\columnbreak

This content is in a second column.

:::: columnbreak
::::

This content is in a third column.

:::: column-break
::::

This content is in a fourth column.

:::

**Warning and limitations**

* In `html`, browsers may ignore explicit column breaks.
* A `\columnbreak` break must be preceded by an empty line
  and occupy a line on its own.
* A `::: columnbreak` break must be followed by a closing
  line of `:::`.

When columnbreaks are explicitly specified, they are used to determine the number of columns. If the section both speficies a number of columns and
includes explicit columnbreaks, the greatest number is used.

### Container syntax

A multicolumn section with explicit breaks can also be written using a container syntax, with `column` sections included in a `columns` section,
as follows.

``` markdown
:::::: columns

::: column

First column content here

:::

::: column

Second column content

:::

:::::
```

This follows [`pandoc`'s markdown syntax for `beamer` output](https://pandoc.org/MANUAL.html#columns). Note that individual column widths
and further column attributes available in `beamer` outputs are not
supported here.

Container syntax and columnbreak syntax can be mixed, as in the example below:

:::::: columns

::: column

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a ante
in mi ornare volutpat sed sit amet diam. Nullam interdum erat a augue
faucibus, nec tempus tortor sagittis. Aenean imperdiet imperdiet
dignissim. Nam aliquam blandit ex, sed molestie nibh feugiat ac. Morbi
feugiat convallis semper. Ut et consequat purus. Fusce convallis
vehicula enim in vulputate. Curabitur a augue arcu.

:::

Mauris laoreet
lectus arcu, sed elementum turpis scelerisque id. Etiam porta turpis
quis ipsum dictum vulputate. In ut convallis urna, at imperdiet nunc.
Cras laoreet, massa lobortis gravida egestas, lacus est pellentesque
arcu, imperdiet efficitur nibh dolor vel sapien. Sed accumsan
condimentum diam non pellentesque.

\columnbreak

Vestibulum cursus nisi risus, sit amet consectetur massa suscipit nec.
Sed condimentum, est id iaculis ornare, purus risus finibus felis,
posuere congue est nibh eget dui. Maecenas orci erat, commodo auctor
justo quis, vestibulum mollis ex.

:::::

### Span elements

EXPLAIN DETAILS HERE

Advanced usage
--------------

### Nesting

Multicolumn sections can be nested.

ILLUSTRATE, TELL THAT SUPPORT VARIES

### Number of columns

Number of columns can be specified in English up to ten. Accepted patterns are `<number>columns`, `<number>-columns` and `<number>_columns`. Note that this is a "class", and should be preceded by a dot when specified along other attributes within curly brackets:

```
::: twocolumns

::: {.three-columns columnsep=2em}

:::

```

Alternatively, the `column-count` can be used to specify any number of columns.

```
::: {.columns column-count=3}
```

If both English names and `column-count` are used, the former prevails.

### HTML output

EXPLAIN

Contributing
------------

Issues and pull requests can be submitted to the repository.

References
----------

* `html`: [CSS Multi-column layout](https://drafts.csswg.org/css-multicol)
* LaTeX: [`multicol` LaTeX package](https://www.ctan.org/pkg/multicol)
