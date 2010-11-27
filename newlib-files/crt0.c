extern int main(); //int argc, char **argv, char **environ);

extern void initC2D();


int _Dmain(){
	initC2D();

	return main();
}
