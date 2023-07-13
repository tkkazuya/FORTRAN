using Random
using Plots
using LaTeXStrings

include("Montecarlo_Metropolis.jl")

step_equilibration = 10000
step_MC = 50000
measure_interval = 10
Ts = range(0.01, 5.01, length=200)
h = 0
plt_E = plot()
plt_m = plot()
plt_absm = plot()
plt_C = plot()
plt_x = plot()

for n = 2:6
    L = 2^n
    local E_T = []
    local m_T = []
    local absm_T = []
    local C_T = []
    local x_T = []
    for T in Ts
        E_mean, m_mean, absm_mean, C_mean, x_mean = Ising_Montecarlo_Metropolis(step_equilibration, step_MC, measure_interval, h, T, L)

        push!(E_T, E_mean)
        push!(m_T, m_mean)
        push!(absm_T, absm_mean)
        push!(C_T, C_mean)
        push!(x_T, x_mean)
    end

    #グラフ描画
    gr()
    plot!(plt_E, Ts, E_T, framestyle=:box, label="N="*string(L), xlabel=L"\tilde{T}", ylabel=L"\tilde{E}", title="Temperature Dependence of Energy")
    plot!(plt_m, Ts, m_T, framestyle=:box, label="N="*string(L), xlabel=L"\tilde{T}", ylabel=L"\tilde{m}", title="Temperature Dependence of Magnetization")
    plot!(plt_absm, Ts, absm_T, framestyle=:box, label="N="*string(L), xlabel=L"\tilde{T}", ylabel=L"|\tilde{m}|", title="Temperature Dependence of Magnetization")
    plot!(plt_C, Ts, C_T, framestyle=:box, label="N="*string(L), xlabel=L"\tilde{T}", ylabel=L"\tilde{C}", title="Temperature Dependence of Specific Heat")
    plot!(plt_x, Ts, x_T, framestyle=:box, label="N="*string(L), xlabel=L"\tilde{T}", ylabel=L"\tilde{\chi}", title="Temperature Dependence of spin susceptibility")
end
savefig(plt_E, "E_Tdep.pdf")
savefig(plt_m, "m_Tdep.pdf")
savefig(plt_absm, "absm_Tdep.pdf")
savefig(plt_C, "C_Tdep.pdf")
savefig(plt_x, "x_Tdep.pdf")