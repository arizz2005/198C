#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  int numlines;
  int numlines_set = 0;

  int c;
  while ((c = getopt(argc, argv, "n:")) != -1) {
    switch (c) {
      case 'n':
        numlines_set = 1;
        numlines = atoi(optarg);
        break;
      default:
        fprintf(stderr, "Unknown command flag -%c ignored.\n", c);
        break;
    }
  }

  if (!numlines_set) {
    fprintf(stderr, "Required flag -n missing!  Quitting.\n");
    exit(1);
  }

  if (argc != (optind + 2)) {
    fprintf(stderr, "Wrong numbers of arguments!  Quitting.\n");
    exit(1);
  }

  FILE *in;
  if (!(in = fopen(argv[optind], "r"))) {
    fprintf(stderr, "Could not open %s for reading!  Quitting.\n",
            argv[optind]);
    exit(1);
  }

  FILE *out;
  if (!(out = fopen(argv[optind + 1], "w"))) {
    fprintf(stderr, "Could not open %s for writing!  Quitting.\n",
            argv[optind + 1]);
    exit(1);
  }

  char *line = NULL;
  size_t line_size;
  for (int count = 0; count < numlines; ++count) {
    if (getline(&line, &line_size, in) < 0) break;
    fprintf(out, "%s", line);
  }
  fclose(in);
  fclose(out);
}
