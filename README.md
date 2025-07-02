# NAME

Query::Tags - Raku-inspired query language for attributes

# SYNOPSIS

    use Query::Tags;

    # Select all @books for which the 'title' field matches the regex /Perl/.
    my $q = Query::Tags->new(q[:title/Perl/]);
    my @shelf = $q->select(@books);

## VERSION

This document describes v0.0.1 of Query::Tags.

# DESCRIPTION

Query::Tags implements a simple query language for stringy object attributes.
Its main features are:

- Attribute syntax

    `:key(value)` designates that an object should have a field or method
    named `key` whose value should match `value`. If `value` is
    missing (is `undef`), the key or field should exist.

- Regular expressions

    Perl regular expressions are fully supported.

- Junctions

    Simple logic operations on queries is supported in the form of junctions
    (as in Raku). For example, `:title!</Dummies/ /in \d+ days/>` matches
    all books whose `title` field matches neither `/Dummies/` nor makes an
    `/in \d+ days/`.

- Pegex grammar

    The language is specified using a [Pegex](https://metacpan.org/pod/Pegex) grammar which means that it can
    be easily changed and extended. You can also supply your own [Pegex::Receiver](https://metacpan.org/pod/Pegex%3A%3AReceiver)
    to the Pegex parser engine, for instance to compile a Query::Tags query to SQL.

This feature set allows for reasonably flexible filtering of tagged, unstructured
data (think of email headers). They also allow for a straightforward query syntax
and quick parsing (discussed in detail below).

It does not support:

- Nested data structures

    There is no way to match values inside a list, for example.

- Types

    There is no type information. All matching is string-based.

- Complex logic

    Junctions provide only a limited means for using logical connectives with
    query assertions. You _can_ specify "all books whose title is X or Y" but
    you _cannot_ specify "all books whose title is X or whose author is Y".

## Methods

### new

    my $q = Query::Tags->new($query_string);

Parses the query string and creates a new query object.
The query is internally represented by a syntax tree.

### tree

    my $root = $q->tree;

Get the root of the underlying syntax tree representation.
It is an object of class [Query::Tags::To::AST::Query](https://metacpan.org/pod/Query%3A%3ATags%3A%3ATo%3A%3AAST#Query::Tags::To:AST::Query).

### test

    $q->test($obj) ? 'PASS' : 'FAIL'

Check if the given object passes all query assertions in `$q`.

### select

    my @pass = $q->select(@objs);

Return all objects which pass all query assertions in `$q`.

## Exports

### parse\_query

    my $q = parse_query($query_string);

Optional export which provides a more procedural interface
to [the constructor](#new) of this package.

# AUTHOR

Tobias Boege <tobs@taboege.de>

# COPYRIGHT AND LICENSE

This software is copyright (C) 2025 by Tobias Boege.

This is free software; you can redistribute it and/or
modify it under the terms of the Artistic License 2.0.
