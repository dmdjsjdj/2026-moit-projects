package com.moit.advertisement.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AdvertisementAnalyticsDto {

    private LocalDate statDate;

    private Long advertisementId;

    private String title;

    private String grade;

    private String position;

    private Long impressions;

    private Long clicks;
}