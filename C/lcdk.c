#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cdk.h>
#include <cdkscreen.h>

#include "lcdk.h"

char * toCharPtr (char * str, int n)
{
    str[n] = '\0';
    return str;
}

char ** toCharDblPtr (char * str, int n)
{
    int i;
    char ** ptr;
    char ** ptrorig;
    char tmp[4000];

    ptr = (char **)malloc(sizeof(char *) * n);
    ptrorig = ptr;
    tmp[0] = '\0';

    i = 1;
    for (str;*str != '\0'; str++) {
	if (*str == '\n') {
	    *(ptr) = (char *)malloc(sizeof(char) * i);
	    tmp[i-1] = '\0';
	    strncpy(*(ptr), tmp, i);
	    ptr++;
	    i = 1;
	    continue;
	}
	tmp[i-1] = *str;
	i++;
    }

    return ptrorig;
}

char ** toCharDblPtr2 (char * str, int n)
{
    int i;
    char ** ptr;
    char ** ptrorig;
    char tmp[4000];

    ptr = (char **)malloc(sizeof(char *) * n);
    ptrorig = ptr;
    tmp[0] = '\0';


    i = 1;
    for (str;*str != '\0'; str++) {
	if (*str == '\n') {
	    *(ptr) = (char *)malloc(sizeof(char) * i);
	    tmp[i-1] = '\0';
	    strncpy(*(ptr), tmp, i);
	    ptr++;
	    i = 1;
	    continue;
	}
	tmp[i-1] = *str;
	i++;
    }

    return ptrorig;
}


int _CDKReadFile (char *fname, CDKFileContent *fcontent)
{
    FILE *fd = fopen("/tmp/otro", "aw");

    fprintf(fd,"Calling CDKReadFile\n");
    fprintf(fd, "Readed %p ...\n", &(fcontent->info));
    fflush(fd);
    fcontent->lines = CDKreadFile(fname, &(fcontent->info));
    fprintf(fd, "Readed %d lines\n", fcontent->lines);
    fflush(fd);
    return fcontent->lines;
};

CDKDIALOG * __newCDKDialog (CDKSCREEN * screen, int xpos, int ypos, char *msg,
    int nmsg, char * buttons, int nbuttons, chtype highlight,
    boolean separator, boolean box, boolean shadow)
{
    CDKDIALOG  *dialog;
    int i;
    char **dblmsg = toCharDblPtr(msg, nmsg);
    char **dblbtns = toCharDblPtr(buttons, nbuttons);

    dialog = newCDKDialog(screen, xpos, ypos, dblmsg, nmsg, dblbtns, nbuttons,
        highlight, separator, box, shadow);

    return dialog;
}

CDKSELECTION * __newCDKSelection (CDKSCREEN * screen, int xpos, int ypos, int spos,
    int height, int width, char * title, char *slist, int slistlength,
    char *clist, int clistlength, chtype highlight, boolean box,
    boolean shadow)
{
    CDKSELECTION  *selection;
    char **dblslist = toCharDblPtr(slist, slistlength);
    char **dblbchoice = toCharDblPtr(clist, clistlength);

    selection = newCDKSelection(screen, xpos, ypos, spos, height, width, title,
        dblslist, slistlength, dblbchoice, clistlength, highlight, box, shadow);

    return selection;
}

// TODO: add this into an alien struct
int __CDKSelectionGetSelection (CDKSELECTION * selection, int x)
{
    return selection->selections[x];
}
int __CDKSelectionGetListSize (CDKSELECTION * selection)
{
    return selection->listSize;
}

CDKITEMLIST * __newCDKItemlist (CDKSCREEN * screen, int xpos, int ypos,
    char *title, char *label, char *list, int listcount, int defaultitem,
    int box, int shadow)
{
    char ** dbllist = toCharDblPtr(list, listcount);

    return newCDKItemlist(screen, xpos, ypos, title, label, dbllist, listcount,
        defaultitem, box, shadow);
};

CDKRADIO * __newCDKRadio (CDKSCREEN * screen, int xpos, int ypos, int spos,
    int height, int width, char * title, char **radiolist, int radiolistcount,
    chtype choicechar, int defaultitem, chtype highlight, boolean box,
    boolean shadow)
{
    char **dbllist = toCharDblPtr(radiolist, radiolistcount);

    return newCDKRadio(screen, xpos, ypos, spos, height, width, title, dbllist,
        radiolistcount, choicechar, highlight, defaultitem, box, shadow);
};

CDKLABEL * __newCDKLabel (CDKSCREEN * screen, int xpos, int ypos, char *msg,
			  int nmsg, boolean box, boolean shadow)
{
    int i;
    CDKLABEL *label;
    char **dblmsg;
    dblmsg = toCharDblPtr(msg, nmsg);

    label = newCDKLabel(screen, xpos, ypos, dblmsg, nmsg, box, shadow);
    for (i=0;i<nmsg;i++)
	free(dblmsg[i]);

    free(dblmsg);

    return label;
}

void __setCDKLabel (CDKLABEL *label, char *msg, int n, boolean box) {
    int i;
    //	FILE *fd = fopen("/tmp/otro", "aw");
    char **dblmsg;

    dblmsg = toCharDblPtr(msg, n);

    //	fprintf(fd,"__setCDKLabel:\n");
    //	fprintf(fd,"MSG: %s<----\n", msg);
    //	fflush(fd);

    setCDKLabel(label, dblmsg, n, box);
    for (i=0;i<n;i++)
	free(dblmsg[i]);
    free(dblmsg);
}

void __drawCDKLabel (CDKLABEL * label, int box)
{
    return drawCDKLabel(label, box);
}

void __drawCDKFselect (CDKFSELECT * fselect, int box)
{
    drawCDKFselect(fselect, box);
}

int _color_pair (int color)
{
    return COLOR_PAIR(color);
}

void * _getObj (void *widget)
{

    return widget;

}

CDKSCREEN * _screenOf (void * obj)
{
    return ((CDKOBJS *)_getObj(obj))->screen;
}

void _setCDKSwindowBackgroundColor (CDKSWINDOW * w, char *color)
{

    setCDKObjectBackgroundColor(ObjOf(w), color);
}

char * _activateCDKFselect (CDKFSELECT * widget, chtype *act)
{
    return copyChar(activateCDKFselect(widget, act));
}
static CDKOBJS *bindableObject (EObjectType * cdktype, void *object)
{
    CDKOBJS *obj = (CDKOBJS *)object;

    if (obj != 0 && *cdktype == ObjTypeOf (obj))
	{
	    if (*cdktype == vFSELECT)
		{
		    *cdktype = vENTRY;
		    object = ((CDKFSELECT *)object)->entryField;
		}
	    else if (*cdktype == vALPHALIST)
		{
		    *cdktype = vENTRY;
		    object = ((CDKALPHALIST *)object)->entryField;
		}
	}
    else
	{
	    object = 0;
	}
    return (CDKOBJS *)object;
}
void _unbindCDKObject (EObjectType cdktype, void * object, chtype key)
{
    FILE *fd = fopen("/tmp/otro", "aw");

    CDKOBJS *obj = bindableObject (&cdktype, object);

    fprintf(fd, "\nUnbindg Key: %d [%c] - %d\n", (unsigned)key, (unsigned) key,
	    obj->bindingCount);
    fflush(fd);
    if (obj != 0 && ((unsigned)key < obj->bindingCount))
	{
	    //		if (obj->bindingList[key]) {
	    obj->bindingList[key].bindFunction = 0;
	    obj->bindingList[key].bindData = 0;
	    fprintf(fd,"reseting key %d\n", key);
	    fflush(fd);
	    //		} else {
	    //			fprintf(fd, "Key not binded\n");
	    //			fflush(fd);
	    //		}

	}
    fflush(fd);
}
