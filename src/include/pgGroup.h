//////////////////////////////////////////////////////////////////////////
//
// pgAdmin III - PostgreSQL Tools
// Copyright (C) 2002, The pgAdmin Development Team
// This software is released under the pgAdmin Public Licence
//
// pgGroup.h - PostgreSQL Group
//
//////////////////////////////////////////////////////////////////////////

#ifndef PGGroup_H
#define PGGroup_H

// wxWindows headers
#include <wx/wx.h>

// App headers
#include "pgAdmin3.h"
#include "pgConn.h"
#include "pgObject.h"
#include "pgServer.h"

// Class declarations
class pgGroup : public pgObject
{
public:
    pgGroup(const wxString& newName = wxString(""));
    ~pgGroup();

    void ShowTreeDetail(wxTreeCtrl *browser, frmMain *form=0, wxListCtrl *properties=0, wxListCtrl *statistics=0, ctlSQLBox *sqlPane=0);
    static void ShowTreeCollection(pgCollection *collection, frmMain *form, wxTreeCtrl *browser, wxListCtrl *properties, wxListCtrl *statistics, ctlSQLBox *sqlPane);
    wxString GetSql(wxTreeCtrl *browser);

    // Group Specific

    void iSetServer(pgServer *s) { server=s; }
    long GetGroupId() const { return groupId; }
    void iSetGroupId(const long l) { groupId=l; }
    long GetMemberCount() const { return memberCount; }
    void iSetMemberCount(const long l) { memberCount=l; }
    wxString GetMemberIds() const { return memberIds; }
    void iSetMemberIds(const wxString& s) { memberIds=s; }
    wxString GetMembers() const { return members; }
    void iSetMembers(const wxString& s) { members=s; }

private:
    long groupId, memberCount;
    wxString memberIds, members, quotedMembers;

    pgServer *server;
};

#endif
