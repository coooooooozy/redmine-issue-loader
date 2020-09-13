package com.enjoyxstudy.redmine.issue.loader.input;

import com.enjoyxstudy.redmine.issue.loader.client.QueryParameter;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class IssueId implements PrimaryKey {
    
    public static final String NAME = "issue_id";

    private int id;

    @Override
    public QueryParameter getQueryParameter() {
        return new QueryParameter(NAME, String.valueOf(id));
    }
}
