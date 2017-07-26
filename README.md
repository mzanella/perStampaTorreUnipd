Script per la stampa in Torre Archimede
=======================================

## Usage

This is a script for help printing operation in laboratories of unipd.
It allows to concatenate multiple PDF files and put 1, 2 or 4 slides per page.

usage: ./perStampaTorre.sh [-h] [<args>]
    where:
          -h show this help
          <args> could be formatted as: 
             1. inputFile1.pdf ... inputFileN.pdf outputFileName.pdf
             2. inputFile1.pdf ... inputFileN.pdf 
                in this case during the script the name of output file is asked
             if no args are passed to the script the name of input and output files are asked during the script
	     CAUTION! input file name cannot contain spaces


The number of slides per pages is asked during the script. The possibilities are:

1 -> means 1 slide per page


2 -> means 2 slides per pages, with landscape orientation

         |----------|----------|

         |          |          |

         |    S1    |    S2    |

         |          |          |

         |----------|----------|


4 -> means 4 slides per pages, with landscape orientation

         |----------|----------|

         |    S1    |    S2    |

         |----------|----------|

         |    S3    |    S4    |

         |----------|----------|



## Credits

Thanks to @Polpetta for the help