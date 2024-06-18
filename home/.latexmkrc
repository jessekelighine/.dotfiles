$bibtex_use = 2;
$clean_ext = "run.xml synctex.gz nav snm thm soc loc glg acn vrb acr alg bbl glo gls ist";

add_cus_dep('glo', 'gls', 0, 'makeglossaries');
add_cus_dep('acn', 'acr', 0, 'makeglossaries');

sub makeglossaries {
    system "makeglossaries $_[0]";
    if ( -z "$_[0].glo" ) {
        open GLS, ">$_[0].gls";
        close GLS;
    }
    return 0;
}
