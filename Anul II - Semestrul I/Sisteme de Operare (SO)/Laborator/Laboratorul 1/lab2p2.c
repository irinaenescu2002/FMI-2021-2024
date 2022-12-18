// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>
 
int count_ap(const char* text, const char* word){
	int ap = 0;
	char s[500];
	strcpy(s, text);
	char *p = strtok(s, " ");
	while(p){
		if(strcmp(p, word) == 0)
			ap ++;
		p = strtok(NULL, " ");
	}
	return ap;
}
 
int main(){
	char *word = "salut";
	char *text = "un salut a fost afisat, salut iar si Salut din nou";
	printf("%s\n%s\nNumarul aparitiilor: ", word, text);
	printf("%d\n", count_ap(text, word));
	return 0;
}