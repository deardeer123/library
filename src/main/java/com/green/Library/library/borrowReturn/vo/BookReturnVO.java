package com.green.Library.library.borrowReturn.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BookReturnVO {
    private int rtCode;
    private String returnDate;
    private int userCode;
    private String bookCode;
}