# Project costs and revenue to 2030 under three scenarios.
d <- readRDS("outputs/clean.rds")
hist_tot <- aggregate(cbind(cost_total_tn, revenue_tn, members_m) ~ year, d, sum)
# Average annual growth of each driver, 2019-2024
g <- function(x) (x[length(x)] / x[1]) ^ (1 / (length(x) - 1)) - 1
g_members <- g(hist_tot$members_m)
g_cost_pm <- g(hist_tot$cost_total_tn / hist_tot$members_m)   # cost per member (utilisation x unit cost)
scen <- data.frame(scenario = c("Base", "High utilisation", "Cost containment"),
                   cost_pm_growth = c(g_cost_pm, g_cost_pm + 0.03, g_cost_pm - 0.02))
last <- tail(hist_tot, 1); yrs <- 2025:2030
proj <- do.call(rbind, lapply(seq_len(nrow(scen)), function(i) {
  t <- yrs - last$year
  data.frame(scenario = scen$scenario[i], year = yrs,
             cost_tn = last$cost_total_tn * ((1 + g_members) * (1 + scen$cost_pm_growth[i])) ^ t,
             revenue_tn = last$revenue_tn * (1 + g_members) ^ t)   # contributions held at 2024 rates
}))
proj$gap_tn <- proj$revenue_tn - proj$cost_tn
saveRDS(list(hist = hist_tot, proj = proj, growth = c(members = g_members, cost_per_member = g_cost_pm)), "outputs/projection.rds")
