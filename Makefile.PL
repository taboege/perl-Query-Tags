use ExtUtils::MakeMaker;
use ExtUtils::MakeMaker::CPANfile;

WriteMakefile(
    NAME            => 'Query::Tags',
    VERSION_FROM    => 'lib/Query/Tags.pm',
    ABSTRACT_FROM   => 'lib/Query/Tags.pm',
    AUTHOR          => ['Tobias Boege <tobs@taboege.de>'],
    LICENSE         => 'artistic_2',
);

# Compile Pegex grammar
sub MY::postamble {
    <<EOF;
lib/Query/Tags/Grammar.pm : share/query-tags.pgx
\t\$(PERL) -Ilib -MQuery::Tags::Grammar=compile
EOF
}
