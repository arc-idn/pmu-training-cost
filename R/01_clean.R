# Read the input and check it. DATA_DIR points to real data; by default the dummy data is used.
DATA_DIR <- Sys.getenv("DATA_DIR", "data/dummy")
d <- read.csv(file.path(DATA_DIR, "jkn_dummy_segment_year.csv"))
stopifnot(all(c("year", "segment", "members_m") %in% names(d)), !anyNA(d))
# Total cost (Rp trillion) by level of care = members x visits per member x unit cost
d$cost_fktp_tn <- d$members_m * d$fktp_rate * d$fktp_cost / 1000
d$cost_rjtl_tn <- d$members_m * d$rjtl_rate * d$rjtl_cost / 1000
d$cost_ritl_tn <- d$members_m * d$ritl_rate * d$ritl_cost / 1000
d$cost_total_tn <- d$cost_fktp_tn + d$cost_rjtl_tn + d$cost_ritl_tn
d$revenue_tn <- d$members_m * d$contribution_per_member_month * 12 / 1000
saveRDS(d, "outputs/clean.rds")
